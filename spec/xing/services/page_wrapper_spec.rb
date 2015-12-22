require 'xing/services/page_wrapper'

describe Xing::Services::PageWrapper do
  let :list do
    [ :a, :b, :c ]
  end

  let :per_page do
    3
  end

  let :total_items do
    14
  end

  let :page_num do
    2
  end

  subject :wrapper do
    Xing::Services::PageWrapper.new(list, page_num, total_items, per_page)
  end

  it{ expect(subject.current_page).to eq(page_num) }
  it{ expect(subject.total_count).to eq(total_items) }
  it{ expect(subject.limit_value).to eq(per_page) }

  it{ expect(subject.total_pages).to eq(5) }
  it{ expect(subject.map(&:to_s)).to eq(%w[a b c])}
end
