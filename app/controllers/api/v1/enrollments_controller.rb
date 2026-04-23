module Api
  module V1
    class EnrollmentsController < Api::BaseController
      def index
        enrollments = Enrollment.includes(:student, :course).all
        enrollments = enrollments.where(status: params[:status]) if params[:status].present?
        render json: enrollments.as_json(include: [ :student, :course ])
      end
    end
  end
end
