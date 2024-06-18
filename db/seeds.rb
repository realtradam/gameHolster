# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

markdown_sample = <<~HEREDOC
# Telum vim lactente

## Petebam Circe hic mactare vitae tandem super

Lorem markdownum Perseu tetigisse instar. Negat inde calidi sibi, in ora
sanguine; vox excitus pes, in in tibi mella! Portasse morte hic venit, latebras
varios servire libera; hic ad augusta forcipe, *illis* est ubi atque.

Veri inquit pondere. Precatur ego Amymonen quae vidit lunares caput, nequeo, et.
Occidat in nosset pressa, nomine exercita penitus viae gaudent extemplo.
Mensuraque imitamine primum: sine est suas, quo in, est falso est accingere
ibimus ore renuente. Trahit sua nulla per ut vestigia celerique, gemit manes,
quo suae.

```
if (graphic_veronica_traceroute + scanRdram < bittorrent_dtd +
        bugWindowsOrientation) {
    pitchWord = dllTrackbackRemote;
    jquery.batchDot.megabyte(cookie - public, memoryDslamSlashdot(2,
            socialPpcEncryption));
}
cron_analyst = ddr_zettabyte_mips;
var digitize = 1;
var friend_gui = artificial.system(alphaWebsite + domain_ibm(
        install_ospf_definition, mca_camelcase, 4), 551649, active_trinitron(
        microcomputer_spoofing));
```

Ungues in cannae limumque ingrate; in una voce cubitoque fecit. Non nec, uno
vires laesit perque carpere vultus armenta. Via [praetulit clipei
vestis](http://antro.net/) vidit, sive vestes invitas pro ad per nato nam beati.

## Nec hauriret stantis

Illa serpentem fugit inlaesas, cum spoliis vultum arbitrium penates fulmina
caelestia moriens videt insidias. Umidus positi, et ripis feremur sit capit
detur tenens.

- Provolat cum ecce dextro sed suum pomi
- Voce falsa habuit te
- Modo deponere bracchia pectus

Deus canor incurva usu dolisque tuentes, leto Liber iniquae requies declivis ad
fontibus tali, flagratque aquaticus. Rupit stimuloque, conscia, nimiumque ait
nomen est Libycas, undas.

> Humumque spectata et vera, **rugosis causam** iaculo sacra, iunctas rege
> triplices contrahit. Potenti unum cava fama genitor testata summa. Comae sit
> cum, dignissima tauri, formatus promissis *in* quoque [quem
> candidaque](http://sulcomaxima.net/), vitalesque? Pro edere rescindere, premit
> mortisque celeri egredior mare pater, una. Arva tu annos fila valles nocte,
> sero deum densetur **soror siccatque Aeacide** certe undique discordia latent
> et.

Mihi aureus. Eque tuo, illam diris, virgineas erit externis stabula saetae datis
videat vultus depositae nymphas pedum non peto quem.
HEREDOC

platform_tags = [
  "web",
  "desktop",
  "mobile",
  "nintendo 64",
  "other"
]
platform_tags.each do |tag|
  Tag.find_or_create_by!(name: tag, tag_type: "platform")
end

game_tags = [
  "action",
  "tech demo",
  "idk something",
]
game_tags.each do |tag|
  Tag.find_or_create_by!(name: tag, tag_type: "game")
end

user = User.find_or_create_by!(user_name: "realtradam", identifier: "11139432")

data_dir = Rails.root.join('db/lfs')

games = [
  {
    title: 'Orc: Arena of Time',
    description: markdown_sample,
    github_link: 'https://github.com/realtradam/orc-arena-of-time',
    img_rendering: 'pixelated',
    tags: ["web", "desktop"]
  },
  {
    title: 'Bubbles, Behind',
    description: markdown_sample,
    github_link: 'https://github.com/realtradam/TOJam2023',
    img_rendering: 'crisp-edges',
    tags: ["web", "desktop"]
  },
  {
    title: 'Magnet Run',
    description: markdown_sample,
    github_link: 'https://github.com/realtradam/Magnet-Run-3D',
    img_rendering: 'crisp-edges',
    tags: ["web", "desktop"]
  },
  {
    title: 'Optimal Direction',
    description: markdown_sample,
    github_link: 'https://github.com/realtradam/optimal-direction',
    img_rendering: 'crisp-edges',
    tags: ["web", "desktop"]
  },
]

games.each do |game|
  next if Game.exists?(title: game[:title], user_id: 1) # first user is always me
  tags = game[:tags]
  game.delete(:tags)
  game_obj = user.games.new(game)
  game_obj.save_zip("#{data_dir}/Games/#{game[:title]}/index.zip")
  game_obj.card_img.attach(io: File.open("#{data_dir}/Games/#{game[:title]}/card.png"), filename: 'card.png')
  game_obj.char_img.attach(io: File.open("#{data_dir}/Games/#{game[:title]}/character.png"), filename: 'character.png')
  game_obj.title_img.attach(io: File.open("#{data_dir}/Games/#{game[:title]}/title.png"), filename: 'title.png')
  game_obj.titleSlug = game[:title].parameterize
  game_obj.status = 1

  tags.each do |tag|
    tag_obj = Tag.find_by(tag_type: "platform", name: tag)
    if tag_obj
      game_obj.tags << tag_obj
    end
  end

  game_obj.save
end
