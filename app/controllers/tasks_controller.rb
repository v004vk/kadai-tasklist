class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :show, :update, :destroy]
  
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが正常に作成されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが作成されませんでした'
      render :new
    end
  end
  
  def new
    @task = Task.new
  end
  
  def edit
  end
  
  def show
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'タスクが正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      flash[:danger] = '指定タスクの閲覧権限がありません。'
      redirect_to root_url
    end
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
