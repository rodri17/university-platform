module Api
  module V1
    class UniversitiesController < Api::BaseController
      def index
        universities = University.all
        render json: universities
      end

      def show
        university = University.find(params[:id])
        render json: university.as_json(
          include: {
            departments: {
              include: :degrees
            },
            students: {},
            terms: {}
          }
        )
      end
    end
  end
end
