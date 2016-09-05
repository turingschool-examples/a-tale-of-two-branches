# Diffmerge

## Getting Diffmerge

### Installation

Diffmerge can be downloaded from [this website](https://sourcegear.com/diffmerge/)

### Better Installation

Get yourself [Homebrew Cask](https://caskroom.github.io/), and manage all your apps through the terminal. Get it by running the following command.

```sh
brew tap caskroom/cask
```

Then you can install apps via cask:

```sh
brew cask install diffmerge
```

### Configuration

After diffmerge is installed, you'll want to set it to be used with git in your terminal. These commands will configure git to use diffmerge when you want to diff or merge.

```sh
git config --global diff.tool diffmerge
git config --global difftool.diffmerge.cmd "/usr/local/bin/diffmerge \"\$LOCAL\" \"\$REMOTE\""

git config --global merge.tool diffmerge
git config --global mergetool.diffmerge.trustExitCode true
git config --global mergetool.diffmerge.cmd "/usr/local/bin/diffmerge --merge --result=\"\$MERGED\" \"\$LOCAL\" \"\$BASE\" \"\$REMOTE\""
```

Now, when you have a merge conflict that needs resolving, just type:

```sh
git mergetool
```

Diffmerge will automatically open the relevant files that need merging, and allow you to resolve the conflict.

Codebases:
  A story
    - Author and editor are both making changes at the same time. Maybe the opening line is too verbose, and both the author and the editor make a change to it, causing a merge conflict. The author just wants to take his own. He hates the editor's changes. (dickens: opening-line) (editor: first-paragraph)
    - The author and the editor both make changes to a paragraph, and you have to get both sentences in there.
    - Then the editor moves a paragraph that the author also wanted to change. The author agrees that the paragraph should be moved, but needs to get his changes in there. (Swapped the paragraphs at lines 13 and 15. You should make a change to 15, and then merge chapter-3-pacing)
    - The editor made a small change, but was unclear in his commit message what change was made. There's no merge conflicts, but Mr. Dickens wants to know what change the editor made. (word-change)
  A model
    - I'll set up a branch where all of the methods have been alphabetized. Branch off master, and refactor something. Then merge in the alphabetized branch. Make sure your changes persist through the merge conflict.
    - A long list of emojis on one line. In another branch, a single emoji has been changed. Reply to my message in slack with the emoji that was changed.
