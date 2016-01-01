# vim:ft=zsh ts=2 sw=2 sts=2
# lborguetti.zsh-theme

# Make git prompt
function prompt_git(){
  local REF=''
  local STATUS=''
  local PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg_bold[red]%}"
  local PROMPT_SUFFIX=" %{$reset_color%}"
  local PROMPT_DIRTY="%{$fg_bold[blue]%}) %{$fg_bold[yellow]%}%{$reset_color%}"
  local PROMPT_CLEAN="%{$fg_bold[blue]%})"

  # Get the name of the branch we are on
  if [[ "$(command git config --get user.name 2>/dev/null)" != "1" ]]; then
    REF=$(command git symbolic-ref HEAD 2>/dev/null) || \
    REF=$(command git rev-parse --short HEAD 2>/dev/null) || \
    return 0
  fi

  # Checks if working tree is dirty
  STATUS=$(command git status -s 2>/dev/null | tail -n1)
  if [[ -n $STATUS ]]; then
    echo -n "$PROMPT_PREFIX${REF#refs/heads/}$PROMPT_DIRTY$PROMPT_SUFFIX"
  else
    echo -n "$PROMPT_PREFIX${REF#refs/heads/}$PROMPT_CLEAN$PROMPT_SUFFIX"
  fi
}

# Show the current working directory
function prompt_context(){
  local CONTEXT_COLOR="%{$fg_bold[cyan]%}"

  # %~  The  current working directory
  echo -n "$CONTEXT_COLOR%1~ "
}

function prompt_end(){
  if [[ "${USER}x" = "rootx" ]]; then
    echo -n "%{$fg_bold[red]%}%# %{$reset_color%}"
  else
    echo -n "%{$fg_bold[white]%}%# %{$reset_color%}"
  fi
}

# Show ok, fail and jobs running
function prompt_status(){
  local SUCCESS='➜'
  local FAULT='✘'
  local RUNNING='⚙'
  local SUCCESS_COLOR="%{$fg_bold[green]%}"
  local FAULT_COLOR="%{$fg_bold[red]%}"
  local RUNNING_COLOR="%{$fg_bold[yellow]%}"

  if [[ $RETVAL -ne 0 ]] ; then
    echo -n "$FAULT_COLOR$FAULT%s  %{$reset_color%}"
  else
    if [[ $(jobs -l | wc -l) -gt 0 ]]; then
      echo -n "$RUNNING_COLOR$RUNNING%s  %{$reset_color%}"
    else
      echo -n "$SUCCESS_COLOR$SUCCESS%s  %{$reset_color%}"
    fi
  fi
}

## Main Prompt
BUILD_PROMPT(){
  RETVAL=$?
  prompt_status
  prompt_context
  prompt_git
  prompt_end
}

PROMPT='$(BUILD_PROMPT)'
