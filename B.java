public class B extends lib.ABase {
  public static String getPublic() {
    return lib.A.getPublic() + "\n" + getPrivate();
  }

  private static String getPrivate() {
    return "Hello from B!";
  }
}
