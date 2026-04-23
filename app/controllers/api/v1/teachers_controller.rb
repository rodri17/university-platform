module Api
  module V1
    class TeachersController < Api::BaseController
      def index
        teachers = Teacher.includes(:department, :courses).all
        render json: teachers.as_json(include: [ :department, :courses ])
      end

      def show
        teacher = Teacher.includes(:department, :courses).find(params[:id])
        render json: teacher.as_json(include: [ :department, :courses ])
      end

      def create
        teacher = Teacher.new(teacher_params)
        if teacher.save
          render json: teacher.as_json(include: [ :department ]), status: :created
        else
          render json: { errors: teacher.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        teacher = Teacher.find(params[:id])
        if teacher.update(teacher_params)
          render json: teacher.as_json(include: [ :department ])
        else
          render json: { errors: teacher.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        teacher = Teacher.find(params[:id])
        teacher.destroy
        render json: { message: "Teacher deleted successfully" }
      end

      private

      def teacher_params
        params.require(:teacher).permit(:first_name, :last_name, :email, :department_id)
      end
    end
  end
end
