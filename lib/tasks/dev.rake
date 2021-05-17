namespace :dev do
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Excluindo BD...') { `rails db:drop` }
      show_spinner('Criando BD...') { `rails db:create` }
      show_spinner('Migrando BD...') { `rails db:migrate` }
      `rails dev:add_minig_types`
      `rails dev:add_coins`
    else
      puts 'Você não está no ambiente de desenvolvimento!'
    end
  end

  desc 'Cadastra as moedas'
  task add_coins: :environment do
    show_spinner('Cadastrando moedas...') do
      coins = [{
        description: 'Bitcoin',
        acronym: 'BTC',
        url_image: 'https://pngimg.com/uploads/bitcoin/bitcoin_PNG47.png',
        mining_type: MiningType.find_by(acronym: 'PoW')
      }, {
        description: 'Ethereum',
        acronym: 'ETH',
        url_image: 'https://img2.gratispng.com/20180330/wae/kisspng-ethereum-bitcoin-cryptocurrency-logo-tether-bitcoin-5abdfe01b6f4b4.2459439115224007697494.jpg',
        mining_type: MiningType.all.sample
      }, {
        description: 'Dash',
        acronym: 'DASH',
        url_image: 'data:image/png;base64,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',
        mining_type: MiningType.all.sample
      }]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc 'Cadastra os tipos de mineração'
  task add_minig_types: :environment do
    show_spinner('Cadastrando tipos de mineração...') do
      mining_types = [
        { description: 'Proof of Work', acronym: 'PoW' },
        { description: 'Proof of Stake', acronym: 'PoS' },
        { description: 'Proof of Capacity', acronym: 'PoC' }
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = 'Concluído!')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
