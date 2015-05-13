# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



common_adjectives = 
["other", "new", "good", "high", "old", "great", "big", "American", "small", "large", "national", "young", "different", "black", "long", "little", "important", "political", "bad", "white", "real", "best", "right", "social", "only", "public", "sure", "low", "early", "able", "human", "local", "late", "hard", "major", "better", "economic", "strong", "possible", "whole", "free", "military", "true", "federal", "international", "full", "special", "easy", "clear", "recent", "certain", "personal", "open", "red", "difficult", "available", "likely", "short", "single", "medical", "current", "wrong", "private", "past", "foreign", "fine", "common", "poor", "natural", "significant", "similar", "hot", "dead", "central", "happy", "serious", "ready", "simple", "left", "physical", "general", "environmental", "financial", "blue", "democratic", "dark", "various", "entire", "close", "legal", "religious", "cold", "final", "main", "green", "nice", "huge", "popular", "traditional", "cultural", "used", "every", "basic", "known", "several", "united", "historical", "useful", "mental", "scared", "additional", "emotional", "healthy", "actual", "successful", "electrical", "expensive", "pregnant", "intelligent", "interesting", "responsible", "cute", "helpful", "willing", "wonderful", "impossible", "rare", "technical", "typical", "competitive", "critical", "electronic", "immediate", "aware", "educational", "global", "relevant", "accurate", "capable", "dangerous", "dramatic", "efficient", "powerful", "hungry", "practical", "psychological", "severe", "suitable", "numerous", "sufficient", "unusual", "consistent", "existing", "famous", "pure", "afraid", "obvious", "careful", "latter", "obviously", "unhappy", "acceptable", "aggressive", "boring", "distinct", "eastern", "logical", "reasonable", "strict", "successfully", "administrative", "automatic", "civil", "former", "massive", "southern", "unfair", "visible", "alive", "angry", "desperate", "exciting", "friendly", "lucky", "realistic", "sorry", "ugly", "unlikely", "anxious", "comprehensive", "curious", "impressive", "informal", "inner", "pleasant", "sexual", "sudden", "terrible", "unable", "weak", "wooden", "asleep", "confident", "conscious", "decent", "embarrassed", "guilty", "lonely", "mad", "nervous", "odd", "remarkable", "substantial", "suspicious", "tall", "tiny", "more", "some", "one", "all", "many", "most", "such", "even", "just", "any", "each", "much", "own", "another", "same", "few", "still", "both", "specific", "enough", "less", "next", "particular", "least", "last", "individual", "potential", "professional", "lower", "according", "alternative", "working", "true", "dry", "commercial", "primary", "worth", "necessary", "positive", "present", "creative", "fit", "glad", "proper", "complex", "content", "due", "effective", "middle", "regular", "fast", "independent", "original", "wide", "beautiful", "complete", "active", "negative", "safe", "visual", "ago", "quick", "straight", "direct", "excellent", "extra", "junior", "pretty", "unique"]


common_verbs = [
"be", 
"have",  
"do",  
"say",   
"go",  
"get",  
"make",  
"know",  
"think",   
"take",  
"see",   
"come", 
"want",  
"use",   
"find",  
"give", 
"tell",  
"work",
"call",
"try",  
"ask",  
"need",  
"feel",  
"become",  
"leave",   
"put",  
"mean",  
"keep", 
"let",   
"begin",   
"seem", 
"help",  
"show",  
"hear", 
"play",  
"run",   
"move",  
"live",  
"believe",   
"bring",   
"happen", 
"write",   
"sit", 
"stand",  
"lose",  
"pay",   
"meet",  
"include",   
"continue",  
"set",  
"learn",   
"change",  
"lead", 
"understand",  
"watch",  
"follow", 
"stop",  
"create", 
"speak",  
"read", 
"spend", 
"grow", 
"open", 
"walk", 
"win",  
"teach", 
"offer",  
"remember", 
"consider",  
"appear", 
"buy",  
"serve",   
"die", 
"send",  
"build",  
"stay", 
"fall", 
"cut",  
"reach", 
"kill", 
"raise",  
"pass", 
"sell",   
"decide",  
"return",  
"explain",  
"hope", 
"develop",   
"carry",  
"break",   
"receive",   
"agree",   
"support",  
"hit",  
"produce",  
"eat",  
"cover",  
"catch",  
"draw", 
"choose"]



# roxanegay.tumblr.com

data = CLIENT.posts('thats-sus.tumblr.com')
#returns an array of just posts

raw_sentences = data["posts"].collect do |post|
  if post["body"]
    post["body"].split(". ")
  end
end
raw_sentences.flatten!


# get sentences with adjectives
has_adjective_sentences = {}
raw_sentences.each do |sentence|
  if sentence != nil
    sentence.split(" ").each.with_index do |word, i|
      if common_adjectives.include?(word) && sentence.length < 75
        has_adjective_sentences[sentence] ||= {:adjective_index => []}
        has_adjective_sentences[sentence][:adjective_index] << i
      end
    end
  end
end

# get sentences with verbs
has_verb_sentences = {}
raw_sentences.each do |sentence|
  if sentence != nil
    sentence.split(" ").each.with_index do |word, i|
      if common_verbs.include?(word)
        has_verb_sentences[sentence] ||= {:verb_index => []}
        has_verb_sentences[sentence][:verb_index] << i
      end
    end
  end
end

# find sentences with both

final_hash = {}
has_adjective_sentences.each do |sentence, adj_index_pair|
  if has_verb_sentences.has_key?(sentence)
    final_hash[sentence] = {:adjective_index => adj_index_pair[:adjective_index], :verb_index => has_verb_sentences[sentence][:verb_index]}
  end
end

final_hash.each do |sentence,indices|
  Sentence.create(:content => sentence, :adjectives => indices[:adjective_index], :verbs => indices[:verb_index])
end
binding.pry