module Api
  module V1
    class CoursesController < Api::BaseController
      def index
        courses = Course.includes(:teacher, :degree, :term, :schedules).all
        render json: courses_with_images(courses)
      end

      def show
        course = Course.includes(:teacher, :degree, :term, :students, :assignments, :schedules).find(params[:id])
        render json: course.as_json(
          include: [ :teacher, :degree, :term, :assignments, :schedules ]
        ).merge(image: UnsplashService.fetch_image(course.name))
      end

      def search
        query = params[:q].to_s.strip
        courses = Course.includes(:teacher, :degree, :term, :schedules)
        courses = courses.where("courses.name ILIKE ?", "%#{query}%") if query.present?
        courses = courses.where(term_id: params[:term_id])            if params[:term_id].present?
        courses = courses.where(degree_id: params[:degree_id])        if params[:degree_id].present?
        render json: courses_with_images(courses)
      end

      private

      def courses_with_images(courses)
        courses.map do |course|
          course.as_json(include: [ :teacher, :degree, :term, :schedules ])
                .merge(image: UnsplashService.fetch_image(course.name))
        end
      end
    end
  end
end
