class TasksController < ApplicationController
  before_action :set_task, only:[:edit, :show, :update, :destroy]
  
  def index
    @tasks = Task.all
  end
  
  def create
    @task = Task.new(task_params)
    
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
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content)
  end
  
end
