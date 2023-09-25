package lib;

public class A3 {
  public static String getPublic() {
    return getPrivate();
  }

  private static String getPrivate() {
    return "Hello from A3!";
  }
}
