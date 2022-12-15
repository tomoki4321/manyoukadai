class TasksController < ApplicationController
  def index
    @tasks=Task.all.recent_order
    if params[:task].present?
      if params[:task][:task_name].present? && params[:task][:status].present?
        @tasks=Task.where(status: params[:task][:status]).name_search(params[:task][:task_name])
      elsif params[:task][:task_name].present?
        @tasks=Task.name_search(params[:task][:task_name])
      elsif params[:task][:status].present?
        @tasks=Task.where(status: params[:task][:status])
      end
      limit_order_select_and
    end
    limit_order_select_only
  end
  def show
    @task=Task.find(params[:id])
  end

  def new
    @task=Task.new
  end

  def create
    @task=Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def edit
    @task=Task.find(params[:id])
  end

  def update
    @task=Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task=Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:task_name,:task_content,:limit,:status)
  end

  def limit_order_select_and
    if params[:task][:limit_select]=="昇順"
      @tasks = @tasks.limit_order_asc
    elsif params[:task][:limit_select]=="降順"
      @tasks = @tasks.limit_order_desc
    end
  end
  def limit_order_select_only
    if params[:task][:limit_select]=="昇順"
      @tasks = Task.limit_order_asc
    elsif params[:task][:limit_select]=="降順"
      @tasks = Task.limit_order_desc
    end
  end
end
