require_relative './../../spec_helper.rb'

describe FaqModule::ListService do
  describe '#call' do
    context 'list command' do
      context 'Zero faqs in database' do
        it "Return don't find message" do
          @listService = FaqModule::ListService.new({}, 'list')

          response = @listService.call()
          expect(response).to match('Nada Encontrado')
        end
      end

      context 'Two faws in database' do
        it 'Find questions and answer in response' do
          @listService = FaqModule::ListService.new({}, 'list')

          faq1 = create(:faq)
          faq2 = create(:faq)

          response = @listService.call()

          expect(response).to match(faq1.question)
          expect(response).to match(faq1.answer)

          expect(response).to match(faq2.question)
          expect(response).to match(faq2.answer)

        end
      end
    end

    context 'search command' do
      context 'Empty query' do
        it "return don't find message" do
          @listService = FaqModule::ListService.new({'query' => ''}, 'search')

          response = @listService.call()
          expect(response).to match('nada encontrado')
        end
      end

      context 'Valid query' do
        it 'find question and answer in response' do
          faq = create(:faq)

          @listService = FaqModule::ListService.new({'query' => faq.question.split(' ').sample}, 'search')

          response = @listService.call()

          expect(response).to match(faq.question)
          expect(response).to match(faq.answer)
        end
      end
    end

    context 'search_by_hashtag command' do
      context "Invalid hashtag" do
        it "return don find message" do
          @listService = FaqModule::ListService.new({ 'query' => ''}, 'search_by_hashtag')

          response = @listService.call()

          expect(response).to match("Nada Encontrado")
        end
      end

      context "Valid hastag" do
        it "With valid hashtag, find question and answer in response" do
          faq = create(:faq)
          hashtag = create(:hastag)
          create(:faq_hashtag, faq: faq, hashtag: hashtag)

          @listService = FaqModule::ListService.new({ 'query' => hashtag.name }, 'search')

          response = @listService.call()

          expect(response).to match(faq.question)
          expect(response).to match(faq.answer)
        end

      end
    end
  end
end