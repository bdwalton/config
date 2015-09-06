package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"strings"
)

var (
	do_backups = flag.Bool("backup", true, "Backup existing dotfiles.")
	do_dryrun  = flag.Bool("dryrun", false, "No-op mode.")
	be_verbose = flag.Bool("verbose", false, "Be verbose about installation.")
	debug      = flag.Bool("debug", false, "Dispaly debugging info.")
)

func getConfigType() (string, error) {
	ct, err := ioutil.ReadFile("/home/bdwalton/.bdwconfig")
	if err != nil {
		return "", fmt.Errorf("Error reading config: %s", err)
	}

	re := regexp.MustCompile(".*BDW_CONFIG_TYPE\\s*=\\s*(\\w+)")
	md := re.FindStringSubmatch(string(ct))
	if len(md) != 2 {
		return "", fmt.Errorf("Text %q didn't match BDW_CONFIG_TYPE=\\w+.", ct)

	}

	return md[1], nil
}

func getDotFiles(dotfile_path, config_type string) ([]os.FileInfo, error) {
	var entries []os.FileInfo

	entries, err := ioutil.ReadDir(dotfile_path)
	if err != nil {
		return nil, fmt.Errorf("Error scanning dotfiles in %q: %v", dotfile_path, err)
	}

	env_config := regexp.MustCompile("^_.+-\\w+$")
	env_specific_re := fmt.Sprintf("^_.+-%s$", config_type)
	env_specific_config := regexp.MustCompile(env_specific_re)

	var dotfiles []os.FileInfo
	for _, entry := range entries {
		// Skip over env specific configs that aren't for this environment.
		if env_config.MatchString(entry.Name()) &&
			!env_specific_config.MatchString(entry.Name()) {
			if *debug {
				log.Printf("Skipping env-specific dotfile %q\n", entry.Name())
			}
			continue
		}

		if strings.HasPrefix(entry.Name(), "_") {
			dotfiles = append(dotfiles, entry)
		}
	}

	return dotfiles, nil
}

func makeCommand(format string, args ...interface{}) string {
	cmd := fmt.Sprintf(format, args...)
	if *do_dryrun {
		// If we're in dryrun mode, every command is prefixed with echo.
		return "echo " + cmd
	}

	return cmd
}

func getInstallCommands(dotfiles []os.FileInfo, srcdir, destdir string) []string {
	var cmds []string

	if *debug {
		// Make the shell spit out the commands it executes.  (Don't wrap
		// this in debug mode though, since that would prevent it from
		// ever providing useful shell debug output.)
		cmds = append(cmds, "set -x")
	}

	// Bail on error
	cmds = append(cmds, makeCommand("set -e"))

	for _, fileinf := range dotfiles {
		src := filepath.Join(srcdir, fileinf.Name())
		dst := filepath.Join(destdir, "."+fileinf.Name()[1:])

		if *be_verbose {
			cmds = append(cmds, makeCommand("echo Installing %q as %q", src, dst))
		}

		stat, err := os.Lstat(dst)
		switch os.IsNotExist(err) {
		case true:
			cmds = append(cmds, makeCommand("ln -snf %q %q", src, dst))
		default:
			if stat.Mode().IsRegular() || stat.IsDir() {
				if *do_backups {
					cmds = append(cmds, makeCommand("cp -pR %q '%q", dst, dst+".bak"))
					// Do backup here.
					if stat.IsDir() {
						cmds = append(cmds, makeCommand("rm -rf %q", dst))
					}
				}
			}
			cmds = append(cmds, makeCommand("ln -snf %q %q", src, dst))
		}
	}
	return cmds
}

func runCommands(cmds []string) error {
	var output []byte

	cmd := exec.Command("/bin/bash")
	cmd.Stdin = strings.NewReader(strings.Join(cmds, "\n"))
	output, err := cmd.CombinedOutput()
	if err != nil {
		return err
	}

	fmt.Println(string(output))
	return nil
}

func main() {
	flag.Parse()

	configtype, err := getConfigType()
	if err != nil {
		log.Fatalf("Error determining config type: %v", err)
	}

	repodir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		log.Fatalf("Error determining repo: %v", err)
	}

	dotfiledir, err := filepath.Abs(filepath.Join(repodir, "dotfiles"))
	if err != nil {
		log.Fatalf("Error determining dotfile dir: %v", err)
	}

	entries, err := getDotFiles(dotfiledir, configtype)
	if err != nil {
		log.Fatalf("Error listing dotfiles: %v", err)
	}

	cmds := getInstallCommands(entries, dotfiledir, os.Getenv("HOME"))

	if err = runCommands(cmds); err != nil {
		log.Fatalf("Error running commands: %v", err)
	}
}
