import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/row_of_products.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        Center(child: VText().PersianText('کالا های روز', 40, color: DataColor.backgroundColor)),
        RowOfProducts(number: '14', product_name: ' شیر ', price: '2000', onIconPressed: (){},),
        SizedBox(height: screen_height*0.01,),
        RowOfProducts(number: '21', product_name: ' تخ مرغ ', price: '1000', onIconPressed: (){},),
        SizedBox(height: screen_height*0.01,),
        RowOfProducts(number: '22', product_name: ' سبزی ', price: '3000', onIconPressed: (){},),
        

      ],
    );
  }
}