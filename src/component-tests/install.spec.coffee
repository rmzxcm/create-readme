InstallParser = require '../components/install.coffee'

describe "An InstallParser", ->
  pkg = null
  beforeEach ->
    pkg = require '../../package.json'
    pkg.git =
      user: "dbartholomae"
      repo: "readme-creator"
      branch: "master"

  it "returns default options when not configured differently", ->
    installParser = new InstallParser()
    expect(installParser.run pkg).to.eventually.deep.equal
      modules:
        names: [{ name: 'CommonJS' }]
      npmcdn: false

  it "uses different settings if given", ->
    installParser = new InstallParser
      modules: ['CommonJS', 'RequireJS']
      npmcdn: true
    expect(installParser.run pkg).to.eventually.deep.equal
      modules:
        names: [{ name: 'CommonJS' }, { name: 'RequireJS' }]
      npmcdn: true

