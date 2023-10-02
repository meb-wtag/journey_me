require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  let(:valid_params) { FactoryBot.attributes_for(:task) }

  # describe 'GET #index' do
  #   let(:task2) { FactoryBot.create(:task, user_id: user.id) }

  #   before do
  #     session[:user_id] = user.id
  #   end

  #   it 'populates an array of all Tasks' do
  #     get :index, params: { user_id: user.id, task: valid_params }
  #     expect(assigns(:tasks)).to match_array [task, task2]
  #   end

  #   it 'renders the :index template' do
  #     get :index, params: { user_id: user.id, journal: valid_params }
  #     expect(response).to render_template :index
  #   end
  # end

  # describe 'GET #new' do
  #   let!(:task3) { FactoryBot.create(:task, user_id: user.id) }

  #   before do
  #     session[:user_id] = user.id
  #   end

  #   it 'assigns a new Task to @task' do
  #     get :new, params: { user_id: user.id }
  #     expect(assigns(:task)).to be_a_new(Task)
  #   end

  #   it 'renders the :new template' do
  #     get :new, params: { user_id: user.id, id: task.id }
  #     expect(response).to render_template :new
  #   end
  # end

  describe 'GET #show' do
    before do
      session[:user_id] = user.id
    end

    it 'displays the requested Task to @task' do
      get :show, params: { id: task.id }
      expect(assigns(:task)).to eq task
    end

    it 'renders the :show template' do
      get :show, params: { user_id: user.id, id: task.id }
      expect(response).to render_template :show
    end
  end

  describe '#destroy' do
    before do
      session[:user_id] = user.id
    end

    it 'destroys the task' do
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
    end

    it 'redirects to user_tasks_path' do
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to(user_tasks_path)
    end

    context 'when the task cannot be destroyed' do
      before do
        allow_any_instance_of(Task).to receive(:destroy).and_return(false)
      end

      it 'redirects to user_tasks_path' do
        delete :destroy, params: { id: task.id }
        expect(response).to redirect_to(user_tasks_path)
      end
    end
  end

  # describe 'POST #create' do
  #   before do
  #     session[:user_id] = user.id
  #   end

  #   it 'creates a task with params and saves it' do
  #     expect do
  #       post :create, params: { user_id: user.id, task: valid_params }
  #     end.to change(Task, :count).by(1)
  #   end

  #   it 'redirects to journals_path' do
  #     post :create, params: { user_id: user.id, task: valid_params }
  #     expect(response).to redirect_to(user_tasks_path)
  #   end
  # end
end
