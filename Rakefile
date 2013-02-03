#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'rake'
require 'fileutils'

#
# Installation
#

desc "Link shell configuration files"
task :link_shell do
  unless File.exists?(File.join(ENV['HOME'], ".zprezto"))
    # Link zsh files
    run %{ ln -nfs "$HOME/.dotfiles/zsh/prezto" "$HOME/.zprezto" }
    file_operation(Dir.glob('zsh/z*'))
    # Link bash files
    file_operation(Dir.glob('bash/bash*'))
  end
end

# Link vim files
desc "Link vim preference files"
task :link_vim do
  %w[ vimrc gvimrc ].each do |file|
    dest = expand("~/.#{file}")
    unless File.exist?(dest)
      ln_s(expand("../vim/#{file}", __FILE__), dest)
    end
    run %{ ln -nfs "$HOME/.dotfiles/vim" "$HOME/.vim" }
  end
end

# Link various preference files
desc "Link misc preference files"
task :link_etc do

  # Link etc files
  file_operation(Dir.glob('etc/*'))

  # Link git files
  file_operation(Dir.glob('git/git*'))

  # Copy ssh config
  ssh_config = expand("~/.ssh/config")
  unless File.exist?(ssh_config)
    run %{ cp "$HOME/.dotfiles/etc/ssh_config" "$HOME/.ssh/config" }
  end

end

namespace :dev do
  desc "Init and update submodules"
  task :submodules do
    run %{
      cd $HOME/.dotfiles
      git submodule foreach 'git fetch origin; git checkout master; git reset --hard origin/master; git submodule update --recursive; git clean -dfx'
      git clean -dfx
    }
    puts
  end
end

desc "Create all symlinks and copy sample files"
task :setup do
  Rake::Task["link_shell"].execute
  Rake::Task["link_vim"].execute
  Rake::Task["link_etc"].execute
  Rake::Task["dev:submodules"].execute
end

private

def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def file_operation(files, method = :symlink)
  files.each do |f|
    file = f.split('/').last
    source = "#{ENV["PWD"]}/#{f}"
    target = "#{ENV["HOME"]}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exists?(target) || File.symlink?(target)
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %{ mv "$HOME/.#{file}" "$HOME/.#{file}.backup" }
    end

    if method == :symlink
      run %{ ln -nfs "#{source}" "#{target}" }
    else
      run %{ cp -f "#{source}" "#{target}" }
    end

    puts "=========================================================="
    puts
  end
end
