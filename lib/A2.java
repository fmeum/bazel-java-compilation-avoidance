package lib;

public class A2 {
  public static String getPublic() {
    return getPrivate();
  }

  private static String getPrivate() {
    return "Hello from A2!";
  }
}
