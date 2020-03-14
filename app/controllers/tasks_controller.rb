class TasksController < ApplicationController
    def index
        @tasks=Task.all
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
            flash[:success]='Taskが正常に作成されました'
            redirect_to task_url(@task.id)
        else
            flash.now[:danger]='Taskが作成されませんでした'
            render :new
        end
        
    end
    
    def edit
        @task=Task.find(params[:id])
    end

    def update
        @task=Task.new(task_params)
        
        if @task.save
            flash[:success]='Taskが正常に編集されました'
            redirect_to task_url(@task.id)
        else
            flash.now[:danger]='Taskが正常に編集されませんでした'
            render :new
        end
        
    end
    
    def destroy
        @message=Task.find(params[:id])
        @message.destroy
        
        flash[:success]='Taskは正常に削除されました'
        redirect_to tasks_url
    end
    
    def task_params
        params.require(:task).permit(:content)
    end
end
