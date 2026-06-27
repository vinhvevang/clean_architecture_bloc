import 'package:bloc_nearly_complete/features/product/domain/entities/product.dart';
import 'package:bloc_nearly_complete/features/product/presentation/bloc/home_bloc.dart';
import 'package:bloc_nearly_complete/features/product/presentation/bloc/home_event.dart';
import 'package:bloc_nearly_complete/features/product/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quan = TextEditingController();
  TextEditingController editName = TextEditingController();
  TextEditingController editPrice = TextEditingController();
  TextEditingController editQuan = TextEditingController();
  TextEditingController findName = TextEditingController();

  // Dialog lọc theo khoảng giá
  void _showFilterDialog(BuildContext context) {
    final minController = TextEditingController();
    final maxController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Lọc theo giá'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: minController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(label: Text('Giá tối thiểu')),
            ),
            TextFormField(
              controller: maxController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(label: Text('Giá tối đa')),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Xóa bộ lọc giá (minPrice/maxPrice = null)
              context.read<HomeBloc>().add(FilterProductEvent());
              Navigator.pop(ctx);
            },
            child: Text('Xóa lọc'),
          ),
          TextButton(
            onPressed: () {
              final min = int.tryParse(minController.text);
              final max = int.tryParse(maxController.text);
              context
                  .read<HomeBloc>()
                  .add(FilterProductEvent(minPrice: min, maxPrice: max));
              Navigator.pop(ctx);
            },
            child: Text('Áp dụng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ── Thanh tìm kiếm + nút lọc giá ──
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return SafeArea(
        
                  child: Container(
                    height: 56,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: findName,
                            onChanged: (value) {
                              context
                                  .read<HomeBloc>()
                                  .add(FindProductEvent(value));
                            },
                            decoration: InputDecoration(
                              label: Text("Nhap ten sp ..."),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                        // FIX: IconButton lọc giá bên phải thanh tìm kiếm
                        IconButton(
                          onPressed: () => _showFilterDialog(context),
                          icon: Icon(Icons.filter_list),
                          tooltip: 'Lọc theo giá',
                        ),
                      ],
                    ),
                  ),
                
              );
            },
          ),
      
          // ── Grid sản phẩm ──
          Expanded(
            child: Scaffold(
              body: BlocBuilder<HomeBloc, HomeState>(
                builder: (_, state) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 3,
                      crossAxisCount: 2,
                    ),
                    // FIX: dùng filteredProducts.length thay vì products.length
                    itemCount: state.filteredProducts.length,
                    itemBuilder: (context, i) {
                      // FIX: lấy index thực trong full list để delete/edit đúng
                      final actualIndex =
                          state.products.indexOf(state.filteredProducts[i]);
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(state.filteredProducts[i].name),
                              subtitle:
                                  Text("${state.filteredProducts[i].price}"),
                              trailing:
                                  Text("${state.filteredProducts[i].quan}"),
                            ),
                            IconButton(
                              onPressed: () => context.read<HomeBloc>().add(
                                // FIX: dùng actualIndex thay vì i
                                RemoveProductEvent(actualIndex),
                              ),
                              icon: Icon(Icons.delete),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Sua san pham"),
                                      actions: [
                                        TextFormField(
                                          controller: editName,
                                          decoration: InputDecoration(
                                            label: Text("Ten san pham"),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: editPrice,
                                          decoration: InputDecoration(
                                            label: Text("gia"),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: editQuan,
                                          decoration: InputDecoration(
                                            label: Text("so luong"),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Product res = Product(
                                              editName.text,
                                              int.tryParse(editPrice.text) ?? 0,
                                              int.tryParse(editQuan.text) ?? 0,
                                            );
                                            context.read<HomeBloc>().add(
                                              // FIX: dùng actualIndex thay vì i
                                              EditProductEvent(res, actualIndex),
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Text("sua"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("nhap thong tin san pham"),
                        actions: [
                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              label: Text("Ten san pham"),
                            ),
                          ),
                          TextFormField(
                            controller: price,
                            decoration: InputDecoration(label: Text("gia")),
                          ),
                          TextFormField(
                            controller: quan,
                            decoration: InputDecoration(label: Text("so luong")),
                          ),
                          TextButton(
                            onPressed: () {
                              Product res = Product(
                                name.text,
                                int.tryParse(price.text) ?? 0,
                                int.tryParse(quan.text) ?? 0,
                              );
                              context.read<HomeBloc>().add(AddProductEvent(res));
                            },
                            child: Text("them"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
