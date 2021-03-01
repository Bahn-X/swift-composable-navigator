extension NavigationTree {
  public func AnyOf<P: PathBuilder>(
    @NavigationTreeBuilder _ builder: () -> P
  ) -> P {
    builder()
  }
}
