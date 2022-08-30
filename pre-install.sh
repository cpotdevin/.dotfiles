#!/bin/zsh

if [[ ! -f `which xcode-select` ]]
then
  echo 'Installing Xcode'
  xcode-select --install
else
  echo 'Xcode already installed'
fi

if [[ ! -f `which brew` ]]
then
  echo 'Installing Homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo 'Updating Homebrew'
  brew update
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]
then
  echo 'Installing oh-my-zsh'
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
else
  echo 'Updating oh-my-zsh'
  omz update
fi

if [[ ! -f `which mac` ]]
then
  echo 'Installing Mac-CLI'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/install)"
else
  echo 'Updating Mac-CLI'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/update)"
fi
