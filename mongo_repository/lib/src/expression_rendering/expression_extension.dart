import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:nosql_repository/nosql_repository.dart';

extension ExpressionExtension on Expression {
  m.AggregationStage render() {
    final query = renderQuery();
    final ret = m.Match(query);
    return ret;
  }

  Map<String, dynamic> renderQuery() {
    if (this is And) return renderAnd(this as And);
    if (this is Or) return renderOr(this as Or);
    if (this is Not) return renderNot(this as Not);
    if (this is Equal) return renderEqual(this as Equal);
    if (this is NotEqual) return renderNotEqual(this as NotEqual);
    if (this is In) return renderIn(this as In);
    if (this is Like) return renderLike(this as Like);
    if (this is GreaterThan) {
      return renderGreaterThan(this as GreaterThan);
    }
    if (this is GreaterOrEqualThan) {
      return renderGreaterOrEqualThan(this as GreaterOrEqualThan);
    }
    if (this is LessThan) return renderLessThan(this as LessThan);
    if (this is LessOrEqualThan) {
      return renderLessOrEqualThan(this as LessOrEqualThan);
    }

    throw UnimplementedError();
  }

  Map<String, dynamic> renderAnd(And expr) {
    var left = expr.left.renderQuery();
    var right = expr.right.renderQuery();

    final ret = {
      r'$and': [left, right]
    };

    return ret;
  }

  Map<String, dynamic> renderOr(Or expr) {
    var left = expr.left.renderQuery();
    var right = expr.right.renderQuery();

    final ret = {
      r'$or': [left, right]
    };

    return ret;
  }

  Map<String, dynamic> renderNot(Not expr) {
    if (expr.expression is Equal) {
      final eq = expr.expression as Equal;
      return renderNotEqual(NotEqual(eq.left, eq.right));
    }
    if (expr.expression is NotEqual) {
      final eq = expr.expression as NotEqual;
      return renderEqual(Equal(eq.left, eq.right));
    }
    if (expr.expression is GreaterThan) {
      final eq = expr.expression as GreaterThan;
      return renderLessOrEqualThan(LessOrEqualThan(eq.left, eq.right));
    }
    if (expr.expression is GreaterOrEqualThan) {
      final eq = expr.expression as GreaterOrEqualThan;
      return renderLessThan(LessThan(eq.left, eq.right));
    }
    if (expr.expression is LessThan) {
      final eq = expr.expression as LessThan;
      return renderGreaterOrEqualThan(GreaterOrEqualThan(eq.left, eq.right));
    }
    if (expr.expression is LessOrEqualThan) {
      final eq = expr.expression as LessOrEqualThan;
      return renderGreaterThan(GreaterThan(eq.left, eq.right));
    }
    if (expr.expression is Like) {
      final eq = expr.expression as Like;

      var left = renderOperand(eq.left);
      var right = renderOperand(eq.right);

      final rexp = right.toString().replaceAll('%', '.*').replaceAll('_', '.');
      final ret =
          m.where.eq(left, {r'$not': m.BsonRegexp(rexp)}).map[r'$query'];
      return ret;
    }
    final andExpr = expr.expression.renderQuery();
    return {r'$not': andExpr};
  }

  Map<String, dynamic> renderEqual(Equal expr) {
    var left = renderOperand(expr.left);
    var right = renderOperand(expr.right);

    final ret = m.where.eq(left, right).map[r'$query'];
    return ret;
  }

  Map<String, dynamic> renderNotEqual(NotEqual expr) {
    var left = renderOperand(expr.left);
    var right = renderOperand(expr.right);

    final ret = m.where.ne(left, right).map[r'$query'];
    return ret;
  }

  Map<String, dynamic> renderIn(In expr) {
    var left = renderOperand(expr.left);
    var right = renderOperand(expr.right);

    final ret = m.where.eq(left, {r'$in': right}).map[r'$query'];
    return ret;
  }

  Map<String, dynamic> renderLike(Like expr) {
    var left = renderOperand(expr.left);
    var right = renderOperand(expr.right);

    final rexp = right.toString().replaceAll('%', '.*').replaceAll('_', '.');
    final ret = m.where.eq(left, m.BsonRegexp(rexp)).map[r'$query'];
    return ret;
  }

  Map<String, dynamic> renderGreaterThan(GreaterThan expr) {
    var left = renderOperand(expr.left);
    var right = renderOperand(expr.right);

    final ret = m.where.gt(left, right).map[r'$query'];
    return ret;
  }

  Map<String, dynamic> renderGreaterOrEqualThan(GreaterOrEqualThan expr) {
    var left = renderOperand(expr.left);
    var right = renderOperand(expr.right);

    final ret = m.where.gte(left, right).map[r'$query'];
    return ret;
  }

  Map<String, dynamic> renderLessThan(LessThan expr) {
    var left = renderOperand(expr.left);
    var right = renderOperand(expr.right);

    final ret = m.where.lt(left, right).map[r'$query'];
    return ret;
  }

  Map<String, dynamic> renderLessOrEqualThan(LessOrEqualThan expr) {
    var left = renderOperand(expr.left);
    var right = renderOperand(expr.right);

    final ret = m.where.lte(left, right).map[r'$query'];
    return ret;
  }

  dynamic renderOperand(Operand operand) {
    if (operand is FieldPath) return renderFieldPath(operand);
    if (operand is Input) return renderInput(operand);
    if (operand is ListInput) return renderListInput(operand);
    throw UnimplementedError();
  }

  String renderFieldPath(FieldPath operand) {
    return operand.fieldPath;
  }

  dynamic renderInput(Input operand) {
    return operand.value;
  }

  dynamic renderListInput(ListInput operand) {
    return operand.values;
  }
}
