require 'rails_helper'
RSpec.describe TasksController, type: :controller do  
  let!(:task) do
    FactoryBot.create(:task)
  end
  
  describe 'GET #index' do 
    let!(:task2) do
      FactoryBot.create(:task)
    end

    it 'populates an array of all Tasks' do
      get :index
      expect(assigns(:tasks)).to match_array [task, task2]
    end

    it 'redirects to the User page' do
      get :index, params: { id: task.id }
      expect(response).to redirect_to tasks_path
    end
  end

  describe 'GET #new' do 
    it 'assigns a new User to @task' do
      get :new
      expect(assigns :task).to be_a_new(Task)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do 
    it 'displays the requested Task to @task' do
      get :show, params: { id: task.id }
      expect(assigns :task).to eq task
    end

    it 'renders the :show template' do
      get :show, params: { id: task.id }
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do 
    it 'deletes the task' do
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
    end
  end

  describe 'POST #create' do 
    let(:valid_params) do
        FactoryBot.attributes_for(:task)
      end

    it 'creates a user with params and saves it' do
      expect do
        post :create, params: { task: valid_params }
        end.to change(Task, :count).by(1)
    end
  end
  
  describe 'GET #update' do
    it 'updates a Task with params and saves it' do 
      expect do     
        post :update, params: { id: task.id, task: { title: 'title', description: 'Description' }}
        task.reload
      end.to change{task.title}.to 'title'
    end
  end

  it 'renders the :show template' do
    get :update, params: { id: task.id , task: { title: 'title', description:  'Description' }}
    expect(response).to redirect_to task_path(task.id) 
  end
end
