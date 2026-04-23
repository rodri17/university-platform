module Api
  module V1
    class StudentsController < Api::BaseController
      def index
        students = Student.includes(:university, :courses).all
        render json: students.as_json(include: [ :university, :courses ])
      end

      def show
        student = Student.includes(:university, :enrollments, :courses, :submissions).find(params[:id])
        render json: student.as_json(
          include: {
            university: {},
            enrollments: { include: :course },
            submissions: { include: [ :assignment, :grade ] }
          }
        )
      end

      def create
        student = Student.new(student_params)
        if student.save
          render json: student.as_json(include: [ :university ]), status: :created
        else
          render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        student = Student.find(params[:id])
        if student.update(student_params)
          render json: student.as_json(include: [ :university ])
        else
          render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        student = Student.find(params[:id])
        student.destroy
        render json: { message: "Student deleted successfully" }
      end

      private

      def student_params
        params.require(:student).permit(:first_name, :last_name, :email, :university_id)
      end
    end
  end
end
