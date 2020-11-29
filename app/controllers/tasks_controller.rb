class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @tasks = current_user.tasks.recent # .recentはモデルで定義してる
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distince: true)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    # @task = Task.new(task_params.merge(user_id: current_user.id))
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました　"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :image)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
