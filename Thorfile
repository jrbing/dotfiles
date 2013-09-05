#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'thor'
require 'fileutils'

class Dotfiles < Thor
  desc "link_shell", "Link shell configuration files"
  def link_shell
    unless File.exists?(File.join(ENV['HOME'], ".zprezto"))
      # Link zsh files
      run %{ ln -nfs "$HOME/.dotfiles/zsh/prezto" "$HOME/.zprezto" }
      file_operation(Dir.glob('zsh/z*'))
      # Link bash files
      file_operation(Dir.glob('bash/bash*'))
      file_operation(Dir.glob('profile'))
    end
  end

  desc "link_vim", "Link vim preference files"
  def link_vim
    %w[ vimrc gvimrc ].each do |file|
      file_operation(Dir.glob('vim/' + file))
    end
    file_operation(Dir.glob('vim'))
  end

  desc "link_etc", "Link miscellaneous preference files"
  def link_etc

    # Link etc files
    file_operation(Dir.glob('etc/*'))

    # Link git files
    file_operation(Dir.glob('git/git*'))

    # TODO
    # Copy ssh config
    #ssh_config = expand("~/.ssh/config")
    #unless File.exist?(ssh_config)
      #run %{ cp "$HOME/.dotfiles/etc/ssh_config" "$HOME/.ssh/config" }
    #end
  end

  desc "setup", "Create all symlinks and copy sample files"
  def setup
    invoke :link_shell
    invoke :link_vim
    invoke :link_etc
  end

  desc "submodules", "Update submodules to the latest version"
  def submodules
    run %{
      cd $HOME/.dotfiles
      git submodule foreach 'git fetch origin; git checkout master; git reset --hard origin/master; git submodule update --recursive; git clean -dfx'
    }
  end

  #desc "install_rbenv"
  #def install_rbenv 
    #run %{ git clone git://github.com/sstephenson/rbenv.git ~/.rbenv }
    #run %{ git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build }
    #run %{ git clone git://github.com/sstephenson/rbenv-default-gems.git ~/.rbenv/plugins/rbenv-default-gems }
    #run %{ git clone git://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash }
    #run %{ git clone git://github.com/tpope/rbenv-aliases.git ~/.rbenv/plugins/rbenv-aliases }
    #run %{ git clone git://github.com/rkh/rbenv-whatis.git ~/.rbenv/plugins/rbenv-whatis }
    #run %{ git clone git://github.com/rkh/rbenv-use.git ~/.rbenv/plugins/rbenv-use }
    #run %{ git clone git://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update }
  #end

  private

  #def run(cmd)
    #puts "[Running] #{cmd}"
    #`#{cmd}` unless ENV['DEBUG']
  #end

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
end
