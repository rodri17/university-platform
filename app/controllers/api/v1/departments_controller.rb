module Api
  module V1
    class DepartmentsController < Api::BaseController
      def index
        departments = Department.includes(:university, :teachers, :degrees).all
        render json: departments.as_json(include: [:university, :teachers, :degrees])
      end

      def show
        department = Department.find(params[:id])
        render json: department.as_json(include: [:university, :teachers, :degrees])
      end
    end
  end
end