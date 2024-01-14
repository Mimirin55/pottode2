class TasksController < ApplicationController
  def index
    @user = User.find_by(params[:user])
    @tasks = Task.all.order(start_date: :asc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = 'おめでとう！タスクを作成できました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'タスクを作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @tasks = Task.all
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = 'おめでとう！タスクを更新できました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'タスクを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy!
    redirect_to tasks_path, notice: 'タスク完了です！よく頑張りました！'
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :start_date, :end_date)
  end
end
