import 'package:nosql_repository/nosql_repository.dart';

import 'context.dart';

extension ExpressionExtension on Expression {
  String render(Context context) {
    if (this is And) return renderAnd(this as And, context);
    if (this is Or) return renderOr(this as Or, context);
    if (this is Not) return renderNot(this as Not, context);
    if (this is Equal) return renderEqual(this as Equal, context);
    if (this is NotEqual) return renderNotEqual(this as NotEqual, context);
    if (this is In) return renderIn(this as In, context);
    if (this is Like) return renderLike(this as Like, context);
    if (this is GreaterThan) {
      return renderGreaterThan(this as GreaterThan, context);
    }
    if (this is GreaterOrEqualThan) {
      return renderGreaterOrEqualThan(this as GreaterOrEqualThan, context);
    }
    if (this is LessThan) return renderLessThan(this as LessThan, context);
    if (this is LessOrEqualThan) {
      return renderLessOrEqualThan(this as LessOrEqualThan, context);
    }

    throw UnimplementedError();
  }

  String renderAnd(And expr, Context context) {
    var left = expr.left.render(context);
    var right = expr.right.render(context);

    var ret = '($left && $right)';
    return ret;
  }

  String renderOr(Or expr, Context context) {
    var left = expr.left.render(context);
    var right = expr.right.render(context);

    var ret = '($left || $right)';
    return ret;
  }

  String renderNot(Not expr, Context context) {
    var lexpr = expr.expression.render(context);

    var ret = '(!$lexpr)';
    return ret;
  }

  String renderEqual(Equal expr, Context context) {
    var left = renderOperand(expr.left, context);
    var right = renderOperand(expr.right, context);

    var ret = '($left == $right)';
    return ret;
  }

  String renderNotEqual(NotEqual expr, Context context) {
    var left = renderOperand(expr.left, context);
    var right = renderOperand(expr.right, context);

    var ret = '($left != $right)';
    return ret;
  }

  String renderIn(In expr, Context context) {
    var left = renderOperand(expr.left, context);
    var right = renderOperand(expr.right, context);

    var ret = '($left in $right)';
    return ret;
  }

  String renderLike(Like expr, Context context) {
    var left = renderOperand(expr.left, context);
    var right = renderOperand(expr.right, context);

    var ret = '($left like $right)';
    return ret;
  }

  String renderGreaterThan(GreaterThan expr, Context context) {
    var left = renderOperand(expr.left, context);
    var right = renderOperand(expr.right, context);

    var ret = '($left > $right)';
    return ret;
  }

  String renderGreaterOrEqualThan(GreaterOrEqualThan expr, Context context) {
    var left = renderOperand(expr.left, context);
    var right = renderOperand(expr.right, context);

    var ret = '($left >= $right)';
    return ret;
  }

  String renderLessThan(LessThan expr, Context context) {
    var left = renderOperand(expr.left, context);
    var right = renderOperand(expr.right, context);

    var ret = '($left < $right)';
    return ret;
  }

  String renderLessOrEqualThan(LessOrEqualThan expr, Context context) {
    var left = renderOperand(expr.left, context);
    var right = renderOperand(expr.right, context);

    var ret = '($left <= $right)';
    return ret;
  }

  String renderOperand(Operand operand, Context context) {
    if (operand is FieldPath) return renderFieldPath(operand, context);
    if (operand is Input) return renderInput(operand, context);
    if (operand is ListInput) return renderListInput(operand, context);
    throw UnimplementedError();
  }

  String renderFieldPath(FieldPath operand, Context context) {
    return 'entity.' + operand.fieldPath;
  }

  String renderInput(Input operand, Context context) {
    var pname = 'p${context.parameters.length}__';
    context.parameters[pname] = operand.value;

    return '@$pname';
  }

  String renderListInput(ListInput operand, Context context) {
    var pname = 'p${context.parameters.length}__';
    context.parameters[pname] = operand.values;

    return '@$pname';
  }
}
