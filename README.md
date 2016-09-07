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
git config --global mergetool.keepBackup false
git config --global mergetool.diffmerge.cmd "/usr/local/bin/diffmerge --merge --result=\"\$MERGED\" \"\$LOCAL\" \"\$BASE\" \"\$REMOTE\""
```

Now, when you have a merge conflict that needs resolving, just type:

```sh
git mergetool
```

Diffmerge will automatically open the files that need merging, and allow you to resolve the conflict.

## Using Diffmerge

### Charles Dickens and his editor

Not a lot of people know that while writing a tale of two cities, Charles Dickens used Git to more efficiently work with his editor. He was sick of his changes being overwritten by his editor, and found copying the editors changes he wanted to be inefficient.

#### Situation 1: Keeping one change, and dumping the other

If you open chapter 1, you'll find that Dickens' famous opening line has not been written, but that his editor is pushing him to write something.

Dickens creates a new branch (`opening-line`) and writes a masterpiece. His editor has also taken a crack at the `first-paragraph`, and merged his changes into master to get things rolling. When Dickens tries to push his changes, he's asked to pull, and when he does pull, there's a merge conflict.

Simulate this by checking out Dickens' branch, and trying to merge `first-paragraph` into it.

```
git fetch
git checkout first-paragraph
git checkout opening-line
git merge first-paragraph
```

You should see something like the following:

```
Auto-merging chapter1.txt
CONFLICT (content): Merge conflict in chapter1.txt
Automatic merge failed; fix conflicts and then commit the result.
```

Type `git mergetool` to open the conflicting file in diffmerge. You should see 3 panes. The leftmost pane is what the file looked like before you merged. It is the 'local' copy. The rightmost pane is what the file looked like on the branch you're merging in. It's the 'remote' copy. The magic happens in the middle. This is the resolved file. You can't make changes to the left or right (local or remote copies), but you can make any edits you want to the middle. When you click the save icon at the top, whatever you have in the middle pane will be saved, and the merge conflict will be considered resolved.

Diffmerge is telling you that the first line in the file has been changes both locally and on the remote branch. The line is actually highlighted yellow to indicate that there's a conflict, but you can't tell that unless you scroll to the end of the line. The editor's take on the opening line is rubbish. Let's copy our changes into the middle.

You can do this by simply selecting the entire first line on the left, and pasting it over the first line in the middle. If you know that you want to take all of your local changes, and ignore the remote changes, select the line in the pane, and then click icon with an arrow pointing to the right. When you hover over it, it says "Apply change from left." This accepts the change you made locally as the correct change, and marks the conflict as resolved. ⌘+S to save, and ⌘+W to close the window.

If you type `git status` in your terminal, you should get the message `All conflicts fixed but you are still merging.` All you need to do now is commit with a message, and your merge will be complete.


#### Situation 2: Keeping both changes made to the same line



#### Situation 3: A change was made to a line that got moved

1. Open chapter3.txt
2. Make a change to line 15
3. `git merge origin/chapter-3-pacing`


#### Situation 3: Seeing what change was made

1. See that there's a new branch, `word-change`
2. Take a look at it on Github to see what the change is.
3. Give up
4.
```
git checkout master
git difftool word-change
```

### Your Turn!

Open up `merchant.rb`. Rails Engine RETURNS!!!!

There's three class methods that should be instance methods. Refactor `self.revenue_to_merchant`, `self.top_customer` and `self.pending_invoice` to be instance methods.

Then merge `origin/merchant-method-order`

Pro tip: You may want to see what changes have been made on the remote branch, either using difftool or github.

### Other Diffmerge cases

#### See changes before a pull

Whenever you type `git pull`, it automatically fetches changes, and merges them with your current branch. What if you want to see what's about to be merged in from the remote?

Assuming you're on master:

```sh
git fetch
git difftool origin/master
# Take a look at the changes
# Then merge
git merge origin/master
```
