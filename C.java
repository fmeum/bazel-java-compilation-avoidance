public class C {
  public static String getPublic() {
    return B.getPublic() + "\n" + getPrivate();
  }

  private static String getPrivate() {
    return "Hello from C!";
  }
}
