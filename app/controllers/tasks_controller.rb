class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:edit, :show, :update, :destroy]
    before_action :set_task, only: [:show, :edit, :update]
   
    def index
        @tasks=current_user.tasks.all.page(params[:page]).per(10)
    end
    
    def show
    end

    def new
        @task=current_user.tasks.build
    end
    
    def create
        @task=current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success]='Taskが正常に作成されました'
            redirect_to task_url(@task.id)
        else
            flash.now[:danger]='Taskが作成されませんでした'
            render :new
        end
        
    end
    
    def edit
    end

    def update
        
        if @task.update(task_params)
            flash[:success]='Taskが正常に編集されました'
            redirect_to task_url(@task.id)
        else
            flash.now[:danger]='Taskが正常に編集されませんでした'
            render :new
        end
        
    end
    
    def destroy
        @task.destroy
        
        flash[:success]='Taskは正常に削除されました'
        redirect_back(fallback_location: root_path)
    end
    
    private
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def set_task
        @task=current_user.tasks.find(params[:id])
    end
    
    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
      redirect_to root_url
      end
    end
  
end
