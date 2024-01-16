class TasksController < ApplicationController
  before_action :task_reminder
  require 'date'

  def index
    @user = User.find_by(params[:user])
    @tasks = Task.all.order(start_date: :asc).page(params[:page]).per(10)
    @tasks = @tasks.joins(:categories).where(categories:{id:params[:category_id]})if params[:category_id].present?
    @categories = Category.all
  end

  def new
    @task = Task.new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = 'タスクを作成できました！いつも頑張っていてすごいです！'
      redirect_to tasks_path
    else
      flash[:alert] = 'タスクを作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @tasks = Task.all
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = 'おめでとう！タスクを更新できました'
      redirect_to tasks_path
    else
      flash[:alert] = 'タスクを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy!
    flash[:notice] =  'タスク完了です！よく頑張りました！'
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :start_date, :end_date, category_ids: [])
  end

  def task_reminder
    if user_signed_in?
      @tasks = Task.all
      @tasks.each do |task|
        if task.end_date + 1.hour < Time.now
          flash[:alert] = "未完了のタスクがあるよ！大丈夫かな？"
        end
      end
    end
  end
end
