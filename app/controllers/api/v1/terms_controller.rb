module Api
  module V1
    class TermsController < Api::BaseController
      def index
        terms = Term.all
        terms = terms.where(university_id: params[:university_id]) if params[:university_id].present?
        terms = terms.where(season: params[:season])               if params[:season].present?
        terms = terms.where(year: params[:year])                   if params[:year].present?
        render json: terms
      end
    end
  end
end
