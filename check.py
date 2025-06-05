import requests
import subprocess
import sys
import os

CRATE = "geph5-client"
VERSION_FILE = "version"
REPO = "origin"

def get_latest_version():
    url = f"https://crates.io/api/v1/crates/{CRATE}"
    resp = requests.get(url)
    resp.raise_for_status()
    return resp.json()["crate"]["newest_version"]

def get_local_version():
    if not os.path.exists(VERSION_FILE):
        return None
    with open(VERSION_FILE) as f:
        return f.read().strip()

def update_version_file(version):
    with open(VERSION_FILE, "w") as f:
        f.write(version + "\n")

def git_commit_and_push(version):
    subprocess.check_call(["git", "add", VERSION_FILE])
    subprocess.check_call(["git", "commit", "-m", f"update version to {version}"])
    subprocess.check_call(["git", "push", REPO, "HEAD"])

def main():
    latest = get_latest_version()
    local = get_local_version()
    if local == latest:
        print(f"Already up to date: {latest}")
        sys.exit(0)
    print(f"Updating version from {local} to {latest}")
    update_version_file(latest)
    git_commit_and_push(latest)

if __name__ == "__main__":
    main()
