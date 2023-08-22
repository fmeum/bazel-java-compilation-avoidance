public class B {
  public static String getPublic() {
    return A.getPublic() + "\n" + getPrivate();
  }

  private static String getPrivate() {
    return "Hello from B!";
  }
}
