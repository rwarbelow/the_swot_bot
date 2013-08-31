require 'spec_helper'

describe Guardians::StudentsController do
  describe 'GET #show' do
    let(:guardian) { FactoryGirl.create :guardian }
    let(:student) { FactoryGirl.create :student }

    before do
      controller.stub(:current_guardian).and_return(guardian)
    end

    it 'shows students if related' do
      FactoryGirl.create :guardianship, guardian: guardian, student: student
      get :show, id: student.id
      response.should be_success
    end

    it 'does not show students to unrelated guardians' do
      expect {
        get :show, id: student.id
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
