class BlogsController < ApplicationController
  permits :title, :urlname, :gh_login, :gh_repo_name

  before_filter :authenticate_user!, only: [:new, :create]


  def new
    @blog = current_user.blogs.new(gh_repo_name: 'namino')
  end

  def create(blog)
    @blog = current_user.blogs.new(blog)
    @blog.originator = current_user

    if @blog.save
      redirect_to blog_path(@blog.urlname)
    else
      render :new
    end
  end

  def show(urlname)
    @blog = Blog.find_by(urlname: urlname)
  end
end
