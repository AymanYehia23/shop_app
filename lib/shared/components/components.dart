import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));

Widget defaultFormField({
  @required TextEditingController controller,
  TextInputType inputType,
  bool isPassword = false,
  Function validate,
  String label,
  IconData prefix,
  IconData suffix,
  Function suffixPressed,
  Function onSubmit,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      validator: validate,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(icon: Icon(suffix), onPressed: suffixPressed)
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

void navigateTo(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateToAndReplacement(BuildContext context, Widget widget) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));

void showToast({
  String message,
  Color backgroundColor,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildFavItem(model,context,{bool isOldPrice}) => Container(
  padding: const EdgeInsets.all(20.0),
  color: Colors.white,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 120,
            height: 120,
          ),
          if (model.discount != 0 && isOldPrice)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      SizedBox(width: 20,),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                style: TextStyle(fontSize: 14, height: 1.3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${model.price.round().toString()}',
                    style: TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice.toString()}',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  if(isOldPrice)
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: ShopCubit.get(context).favorites[model.id] ? defaultColor : Colors.grey,
                    child: IconButton(
                      icon: Icon(Icons.favorite_outline),
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      iconSize: 14,
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ],
  ),
);

