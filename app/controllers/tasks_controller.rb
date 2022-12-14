class TasksController < ApplicationController
  def index
    @tasks=current_user.tasks.recent_order.page(params[:page])
  end
  def show
    @task=Task.find(params[:id])
  end

  def new
    @task=Task.new
  end

  def create
    @task=Task.new(task_params)
    @task.user_id = current_user.id
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

  def search
    @tasks=current_user.tasks.recent_order.page(params[:page])
    if params[:task].present?
      if params[:task][:task_name].present? && params[:task][:status].present? && params[:task][:label_id].present?
        @task_id=Labelling.where(label_id: params[:task][:label_id]).pluck(:task_id)
        @tasks=current_user.tasks.where(status: params[:task][:status]).name_search(params[:task][:task_name]).where(id: @task_id).page(params[:page])
        limit_order_select_and
        priority_order_and
        render :index
        return
      elsif params[:task][:task_name].present? && params[:task][:label_id].present?
        @task_id=Labelling.where(label_id: params[:task][:label_id]).pluck(:task_id)
        @tasks=current_user.tasks.name_search(params[:task][:task_name]).where(id: @task_id).page(params[:page])
        limit_order_select_and
        priority_order_and
        render :index
        return
      elsif params[:task][:status].present? && params[:task][:label_id].present?
        @task_id=Labelling.where(label_id: params[:task][:label_id]).pluck(:task_id)
        @tasks=current_user.tasks.where(status: params[:task][:status]).where(id: @task_id).page(params[:page])
        limit_order_select_and
        priority_order_and
        render :index
        return
      elsif params[:task][:status].present? && params[:task][:task_name].present?
        @tasks=current_user.tasks.where(status: params[:task][:status]).name_search(params[:task][:task_name]).page(params[:page])
        limit_order_select_and
        priority_order_and
        render :index
        return
      elsif params[:task][:status].present?
        @tasks=current_user.tasks.where(status: params[:task][:status]).page(params[:page])
        limit_order_select_and
        priority_order_and
        render :index
        return
      elsif params[:task][:task_name].present?
        @tasks=current_user.tasks.name_search(params[:task][:task_name]).page(params[:page])
        limit_order_select_and
        priority_order_and
        render :index
        return
      elsif params[:task][:label_id].present?
        @task_id=Labelling.where(label_id: params[:task][:label_id]).pluck(:task_id)
        @tasks=current_user.tasks.where(id: @task_id).page(params[:page])
        limit_order_select_and
        priority_order_and
        render :index
        return
      end
    end
      limit_order_select_only
      priority_order_only
      render :index
  end
  

  private

  def task_params
    params.require(:task).permit(:task_name,:task_content,:limit,:status,:priority,:user_id,label_ids: [])
  end

  def limit_order_select_and
    if params[:task][:limit_select]=="昇順"
      @tasks = @tasks.limit_order_asc.page(params[:page])
    elsif params[:task][:limit_select]=="降順"
      @tasks = @tasks.limit_order_desc.page(params[:page])
    end
  end

  def limit_order_select_only
    if params[:task][:limit_select]=="昇順"
      @tasks = current_user.tasks.limit_order_asc.page(params[:page])
    elsif params[:task][:limit_select]=="降順"
      @tasks = current_user.tasks.limit_order_desc.page(params[:page])
    end
  end

  def priority_order_and
    if params[:task][:priority] == "優先▼"
      @tasks = @tasks.priority_order_desc.page(params[:page])
    elsif params[:task][:priority] == "優先▲"
      @tasks = @tasks.priority_order_asc.page(params[:page])
    end
  end

  def priority_order_only
    if params[:task][:priority] == "優先▼"
      @tasks = current_user.tasks.priority_order_desc.page(params[:page])
    elsif params[:task][:priority] == "優先▲"
      @tasks = current_user.tasks.priority_order_asc.page(params[:page])
    end
  end

end
