class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(10)
  end
    
  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] ="新規taskが作成されました。"
      redirect_to @task
    else
      flash.now[:danger] = "新規taskの作成に失敗しました。"
      render 'new'
    end
  end

  def edit
    set_task
  end

  def update
    set_task
    
    if @task.update(task_params)
      flash[:success] ="taskが更新されました。"
      redirect_to @task
    else
      flash.now[:danger] = "taskの更新に失敗しました。"
      render 'edit'
    end
  end

  def destroy
    set_task
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
