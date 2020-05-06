{
# general
  l="exa --all --git-ignore";
  ls="exa --git-ignore";
  ll="exa --all --long";
  lll="exa --all --long --tree --level=2";

  dr="direnv reload";

  f="fg";

# git
  m="clear && ll && echo '' && (git status 2> /dev/null; exit 0)";
  ggr="cd $(git rev-parse --show-toplevel)";

  gcl="git clone";

  gs="git status";
  gss="git show --stat";
  glg="git log --stat --graph --relative-date --minimal";
  grlg="git reflog";

  ga="git add";
  gaa="git add --all";
  gco="git checkout";
  gcob="git checkout -b";
  grm="git rm -r";

  gc="git commit -v";
  gca="git commit -v -a";
  gcm="git commit -v --amend";
  gcam="git commit -v -a --amend";

  gr="git reset";
  grh="git reset --hard";

  gd="git diff --minimal";
  gds="git diff --minimal --staged";
  gda="git diff --minimal HEAD";

  gmt="git mergetool --no-prompt";
  gm="git merge";
  gma="git merge --abort";
  grb="git rebase";
  grbm="git fetch && git rebase origin/master";
  grbi="git rebase --interactive";
  grbim="git fetch && git rebase --interactive origin/master";
  grbc="git rebase --continue";
  grba="git rebase --abort";
  gcp="git cherry-pick";

  gb="git branch";
  gf="git fetch";
  gp="git push --set-upstream origin $(git branch --show-current)";
  gpf="git push --force-with-lease --set-upstream origin $(git branch --show-current)";
  gl="git pull origin $(git branch --show-current)";
  gptags="git push --tags";
  gpftags="git push --force-with-lease --tags";

  gre="git remote";
  grea="git remote add";
  greao="git remote add origin";
  greau="git remote add upstream";

  gsup="git standup";
  ggone="git gone";

# docker
  dlast="docker ps -l -q";
  dll="docker container ls -a";
  dkillall="docker container kill $(docker container ls -qa)";
  drmall="docker container rm $(docker container ls -qa)";

  k="kubectl";
}
