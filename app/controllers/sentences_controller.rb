class SentencesController < ApplicationController

  def create
    binding.pry
  end

  def new
    @sentences = Sentence.all.shuffle
    @sentence = @sentences.shift
    @verb_positions = @sentence.verbs.collect {|index| index.to_i}
    @adjective_positions = @sentence.adjectives.collect {|index| index.to_i}
  end

end
