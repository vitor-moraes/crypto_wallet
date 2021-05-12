namespace :dev do
  desc 'TODO'
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Excluindo BD...') { `rails db:drop` }
      show_spinner('Criando BD...') { `rails db:create` }
      show_spinner('Migrando BD...') { `rails db:migrate` }
      show_spinner('Populando BD...') { `rails db:seed` }
    else
      puts 'Você não está no ambiente de desenvolvimento!'
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
