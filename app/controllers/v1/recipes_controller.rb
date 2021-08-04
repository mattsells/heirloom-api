module V1
  class RecipesController < ApiController
    def index
      records = policy_scope(Recipe).filter(on(:account_id, :name))

      authorize records

      render json: ::RecipeBlueprint.render(records)
    end

    def create

    end

    def show

    end

    def update

    end

    def destroy

    end

    private

    def recipe_params
      params.require(:recipe).permit(
        :account_id,
        :cover_image,
        :directions,
        :ingredients,
        :name
      )
    end
  end
end
