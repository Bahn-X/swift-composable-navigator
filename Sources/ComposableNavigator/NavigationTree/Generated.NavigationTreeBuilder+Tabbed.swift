// AUTO-GENERATED: Do not edit
import SwiftUI

public extension NavigationTree {
  func Tabbed<ABuilder: PathBuilder, AItem: View>(
    _ nodeItemA: TabbedNodeItem<ABuilder, AItem>
  ) -> _PathBuilder<TabbedNodeA<ABuilder, AItem>> {
    _PathBuilder { element in
      guard case .tabbed(let screen) = element, nodeItemA.tag == screen.activeTab.id else {
        return nil
      }

      return TabbedNodeA<ABuilder, AItem>(nodeItemA: nodeItemA)
    }
  }

  func Tabbed<ABuilder: PathBuilder, AItem: View, BBuilder: PathBuilder, BItem: View>(
    _ nodeItemA: TabbedNodeItem<ABuilder, AItem>, _ nodeItemB: TabbedNodeItem<BBuilder, BItem>
  ) -> _PathBuilder<TabbedNodeAB<ABuilder, AItem, BBuilder, BItem>> {
    _PathBuilder { element in
      guard case .tabbed(let screen) = element, nodeItemA.tag == screen.activeTab.id || nodeItemB.tag == screen.activeTab.id else {
        return nil
      }

      return TabbedNodeAB<ABuilder, AItem, BBuilder, BItem>(nodeItemA: nodeItemA, nodeItemB: nodeItemB)
    }
  }

  func Tabbed<ABuilder: PathBuilder, AItem: View, BBuilder: PathBuilder, BItem: View, CBuilder: PathBuilder, CItem: View>(
    _ nodeItemA: TabbedNodeItem<ABuilder, AItem>, _ nodeItemB: TabbedNodeItem<BBuilder, BItem>, _ nodeItemC: TabbedNodeItem<CBuilder, CItem>
  ) -> _PathBuilder<TabbedNodeABC<ABuilder, AItem, BBuilder, BItem, CBuilder, CItem>> {
    _PathBuilder { element in
      guard case .tabbed(let screen) = element, nodeItemA.tag == screen.activeTab.id || nodeItemB.tag == screen.activeTab.id || nodeItemC.tag == screen.activeTab.id else {
        return nil
      }

      return TabbedNodeABC<ABuilder, AItem, BBuilder, BItem, CBuilder, CItem>(nodeItemA: nodeItemA, nodeItemB: nodeItemB, nodeItemC: nodeItemC)
    }
  }

  func Tabbed<ABuilder: PathBuilder, AItem: View, BBuilder: PathBuilder, BItem: View, CBuilder: PathBuilder, CItem: View, DBuilder: PathBuilder, DItem: View>(
    _ nodeItemA: TabbedNodeItem<ABuilder, AItem>, _ nodeItemB: TabbedNodeItem<BBuilder, BItem>, _ nodeItemC: TabbedNodeItem<CBuilder, CItem>, _ nodeItemD: TabbedNodeItem<DBuilder, DItem>
  ) -> _PathBuilder<TabbedNodeABCD<ABuilder, AItem, BBuilder, BItem, CBuilder, CItem, DBuilder, DItem>> {
    _PathBuilder { element in
      guard case .tabbed(let screen) = element, nodeItemA.tag == screen.activeTab.id || nodeItemB.tag == screen.activeTab.id || nodeItemC.tag == screen.activeTab.id || nodeItemD.tag == screen.activeTab.id else {
        return nil
      }

      return TabbedNodeABCD<ABuilder, AItem, BBuilder, BItem, CBuilder, CItem, DBuilder, DItem>(nodeItemA: nodeItemA, nodeItemB: nodeItemB, nodeItemC: nodeItemC, nodeItemD: nodeItemD)
    }
  }

  func Tabbed<ABuilder: PathBuilder, AItem: View, BBuilder: PathBuilder, BItem: View, CBuilder: PathBuilder, CItem: View, DBuilder: PathBuilder, DItem: View, EBuilder: PathBuilder, EItem: View>(
    _ nodeItemA: TabbedNodeItem<ABuilder, AItem>, _ nodeItemB: TabbedNodeItem<BBuilder, BItem>, _ nodeItemC: TabbedNodeItem<CBuilder, CItem>, _ nodeItemD: TabbedNodeItem<DBuilder, DItem>, _ nodeItemE: TabbedNodeItem<EBuilder, EItem>
  ) -> _PathBuilder<TabbedNodeABCDE<ABuilder, AItem, BBuilder, BItem, CBuilder, CItem, DBuilder, DItem, EBuilder, EItem>> {
    _PathBuilder { element in
      guard case .tabbed(let screen) = element, nodeItemA.tag == screen.activeTab.id || nodeItemB.tag == screen.activeTab.id || nodeItemC.tag == screen.activeTab.id || nodeItemD.tag == screen.activeTab.id || nodeItemE.tag == screen.activeTab.id else {
        return nil
      }

      return TabbedNodeABCDE<ABuilder, AItem, BBuilder, BItem, CBuilder, CItem, DBuilder, DItem, EBuilder, EItem>(nodeItemA: nodeItemA, nodeItemB: nodeItemB, nodeItemC: nodeItemC, nodeItemD: nodeItemD, nodeItemE: nodeItemE)
    }
  }
}
