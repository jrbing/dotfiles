# encoding: UTF-8
require 'thor/actions'
require 'fileutils'

module Valet

  def get_script_name(script=nil)
    if !script
      script = ask("Name for script: ")
    end
    return script
  end

  def get_project_name(project=nil)
    if !project
      project = ask("Name for project: ")
    end
    return project
  end

  def get_datafix_name(datafix=nil)
    if !datafix
      datafix = ask("Name for datafix: ")
    end
    return datafix
  end

  def create_project_directory(project)
    project_directory = File.join(Dir.pwd, project)
    empty_directory(project_directory) unless File.exists?(project_directory)
    return project_directory
  end

  def create_project_subdirectory(subdir)
    subdir_path = File.join(@project_base_directory, subdir)
    empty_directory(subdir_path) unless File.exists?(subdir_path)
    return subdir_path
  end

  def create_datafix_directory(datafix)
    datafix_directory = File.join(Dir.pwd, datafix)
    empty_directory(datafix_directory) unless File.exists?(datafix_directory)
    return datafix_directory
  end

  def create_from_template(template_file, output_file)
    if @project_base_directory
      template(template_file, File.join(@project_base_directory, output_file))
    elsif @datafix_base_directory
      template(template_file, File.join(@datafix_base_directory, output_file))
    else
      template(template_file, File.join(Dir.pwd, output_file))
    end
  end

  def initialize_git_repo(path)
    say_status("info", "Initializing git repo")
    inside(path) do
      run 'git init'
    end
  end

  def add_submodule(repository, submodule_base)
    say_status("info", "Adding project submodule #{repository}")
    inside(submodule_base) do
      run("git submodule add " + repository)
    end
  end

  def update_submodules(path)
    inside(path) do
      run 'git submodule update --init --recursive'
    end
  end


end
