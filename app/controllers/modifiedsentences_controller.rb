class ModifiedsentencesController < ApplicationController

  def show
    @modifiedsentence = Modifiedsentence.find(params[:id])
    @sentence = @modifiedsentence.sentence
  end


  def new
      @sentences = Sentence.all.shuffle
      @sentence = @sentences.shift
      @verb_positions = @sentence.verbs.collect {|index| index.to_i}
      @adjective_positions = @sentence.adjectives.collect {|index| index.to_i}
  end

  def create
    @sentence = Sentence.find(params[:sentence_id])

    original_sentence_array = @sentence.content.split(" ")

    @verb_positions = @sentence.verbs.collect {|index| index.to_i}
    @adjective_positions = @sentence.adjectives.collect {|index| index.to_i}


    @verb_positions.each do |index|
      original_sentence_array[index] = params["verbs"].shift
    end

    @adjective_positions.each do |index|
      original_sentence_array[index] = params["adjs"].shift
    end

    content = original_sentence_array.join(" ")

    @modifiedsentence = Modifiedsentence.create(:content => content)
    @sentence.modifiedsentences << @modifiedsentence
        
    redirect_to @modifiedsentence
  end

  private
  def modifedsentence_params
    params.require(:modifiedsentence).permit(:content)
  end

end
