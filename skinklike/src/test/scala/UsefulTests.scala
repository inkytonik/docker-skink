import org.bitbucket.inkytonik.kiama.util.Tests

class UsefulTests extends Tests {

  import UsefulMain.useful

  test("useful test") {
    useful(20) shouldBe 21
  }

}
