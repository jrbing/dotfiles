require 'thor/actions'
require 'fileutils'

module Valet

  def get_project_name(project=nil)
    if !project
      project = ask("Name for project: ")
    end
    return project
  end

  def create_project_directory(project)
    project_directory = File.join(Dir.pwd, project)
    say_status("info", "Creating project directory at #{project_directory}")
    Dir.mkdir(project_directory) unless File.exists?(project_directory)
    return project_directory
  end

  def create_project_subdirectory(subdir)
    say_status("info", "Creating project subdirectory #{subdir}")
    subdir_path = File.join(@project_base_directory, subdir)
    FileUtils.mkdir_p(subdir_path) unless File.exists?(subdir_path)
    return subdir_path
  end

  def create_from_template(template_file, output_file)
    template(template_file, File.join(@project_base_directory, output_file))
  end

  def initialize_git_repo(path)
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
